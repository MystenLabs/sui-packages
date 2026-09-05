module 0xb2cba7cd4ea67280c7eca8d4d8658cb87c4b9ba6a26c733bde8cbb8a7398ad68::trading_card {
    struct TRADING_CARD has drop {
        dummy_field: bool,
    }

    struct TradingCard has store, key {
        id: 0x2::object::UID,
        athlete_id: 0x1::string::String,
        card_version_id: 0x1::string::String,
        sport: 0x1::string::String,
        season_year: u64,
        player_name: 0x1::string::String,
        rarity_tier: 0x1::string::String,
        edition_size: u64,
        mint_number: u64,
        snapshot_hash: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        listed_in_kiosk: bool,
        kiosk_id: 0x1::string::String,
    }

    struct CardMinted has copy, drop {
        card_id: 0x2::object::ID,
        owner: address,
        season_year: u64,
        edition_size: u64,
        mint_number: u64,
    }

    struct CardKioskStateChanged has copy, drop {
        card_id: 0x2::object::ID,
        listed_in_kiosk: bool,
    }

    struct CardTransferred has copy, drop {
        card_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct MarketSaleExecuted has copy, drop {
        card_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price_mist: u64,
        platform_fee_mist: u64,
    }

    public entry fun create_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<TradingCard>(arg0, arg1, arg5);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<TradingCard>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{player_name} - {sport} Player Card"));
        0x2::display_registry::set<TradingCard>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{sport} player card - season {season_year}"));
        0x2::display_registry::set<TradingCard>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display_registry::set<TradingCard>(&mut v3, &v2, 0x1::string::utf8(b"link"), arg3);
        0x2::display_registry::set<TradingCard>(&mut v3, &v2, 0x1::string::utf8(b"project_url"), arg4);
        0x2::display_registry::set<TradingCard>(&mut v3, &v2, 0x1::string::utf8(b"metadata_url"), 0x1::string::utf8(b"{metadata_uri}"));
        0x2::display_registry::share<TradingCard>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<TradingCard>>(v2, 0x2::tx_context::sender(arg5));
    }

    fun empty_string() : 0x1::string::String {
        0x1::string::utf8(b"")
    }

    entry fun execute_market_sale(arg0: TradingCard, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketSaleExecuted{
            card_id           : 0x2::object::id<TradingCard>(&arg0),
            seller            : 0x2::tx_context::sender(arg5),
            buyer             : arg1,
            price_mist        : arg3,
            platform_fee_mist : arg4,
        };
        0x2::event::emit<MarketSaleExecuted>(v0);
        0x2::transfer::public_transfer<TradingCard>(arg0, arg1);
    }

    fun init(arg0: TRADING_CARD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TRADING_CARD>(arg0, arg1);
    }

    entry fun mint_card(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = TradingCard{
            id              : 0x2::object::new(arg10),
            athlete_id      : arg0,
            card_version_id : arg1,
            sport           : arg2,
            season_year     : arg3,
            player_name     : arg4,
            rarity_tier     : arg5,
            edition_size    : arg6,
            mint_number     : arg7,
            snapshot_hash   : arg8,
            metadata_uri    : arg9,
            listed_in_kiosk : false,
            kiosk_id        : empty_string(),
        };
        let v2 = CardMinted{
            card_id      : 0x2::object::id<TradingCard>(&v1),
            owner        : v0,
            season_year  : arg3,
            edition_size : arg6,
            mint_number  : arg7,
        };
        0x2::event::emit<CardMinted>(v2);
        0x2::transfer::transfer<TradingCard>(v1, v0);
    }

    entry fun place_in_kiosk(arg0: &mut TradingCard, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.listed_in_kiosk = true;
        arg0.kiosk_id = arg1;
        let v0 = CardKioskStateChanged{
            card_id         : 0x2::object::id<TradingCard>(arg0),
            listed_in_kiosk : true,
        };
        0x2::event::emit<CardKioskStateChanged>(v0);
    }

    entry fun remove_from_kiosk(arg0: &mut TradingCard, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.listed_in_kiosk = false;
        arg0.kiosk_id = empty_string();
        let v0 = CardKioskStateChanged{
            card_id         : 0x2::object::id<TradingCard>(arg0),
            listed_in_kiosk : false,
        };
        0x2::event::emit<CardKioskStateChanged>(v0);
    }

    entry fun transfer_card(arg0: TradingCard, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CardTransferred{
            card_id : 0x2::object::id<TradingCard>(&arg0),
            from    : 0x2::tx_context::sender(arg2),
            to      : arg1,
        };
        0x2::event::emit<CardTransferred>(v0);
        0x2::transfer::public_transfer<TradingCard>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

