module 0x904a20c461e6893503e2732267b717fba937353ef5e6dc921d88e89a90967b7::gm_coin {
    struct GM_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<GM_COIN>,
    }

    fun init(arg0: GM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM_COIN>(arg0, 9, b"GMC", b"GM Coin", b"gm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://keylayapps.nyc3.cdn.digitaloceanspaces.com/gm-sui-coin.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GM_COIN>>(v1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    public fun mint_one(arg0: &mut TreasuryCapHolder, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GM_COIN>(&mut arg0.treasury_cap, 1000000000, 0x2::tx_context::sender(arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

