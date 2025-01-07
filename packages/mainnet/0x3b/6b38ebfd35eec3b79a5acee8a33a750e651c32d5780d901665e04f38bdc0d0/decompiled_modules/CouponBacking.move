module 0x3b6b38ebfd35eec3b79a5acee8a33a750e651c32d5780d901665e04f38bdc0d0::CouponBacking {
    struct DiscountCoupon has store, key {
        id: 0x2::object::UID,
        issuer: address,
        discount: 0x1::ascii::String,
        expiration: 0x1::ascii::String,
        url: 0x2::url::Url,
    }

    struct RareCollectable has store, key {
        id: 0x2::object::UID,
        issuer: address,
        url: 0x2::url::Url,
        collectable: 0x1::ascii::String,
        series: 0x1::ascii::String,
    }

    struct ExclusiveTicket has store, key {
        id: 0x2::object::UID,
        issuer: address,
        url: 0x2::url::Url,
        event: 0x1::ascii::String,
        date: 0x1::ascii::String,
    }

    struct GloriousTrophy has store, key {
        id: 0x2::object::UID,
        issuer: address,
        url: 0x2::url::Url,
        rank: 0x1::ascii::String,
        event: 0x1::ascii::String,
    }

    public entry fun burn_DiscountCoupon(arg0: DiscountCoupon, arg1: &mut 0x2::tx_context::TxContext) {
        let DiscountCoupon {
            id         : v0,
            issuer     : _,
            discount   : _,
            expiration : _,
            url        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun burn_ExclusiveTicket(arg0: ExclusiveTicket, arg1: &mut 0x2::tx_context::TxContext) {
        let ExclusiveTicket {
            id     : v0,
            issuer : _,
            url    : _,
            event  : _,
            date   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun burn_GloriousTrophy(arg0: GloriousTrophy, arg1: &mut 0x2::tx_context::TxContext) {
        let GloriousTrophy {
            id     : v0,
            issuer : _,
            url    : _,
            rank   : _,
            event  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun burn_RareCollectable(arg0: RareCollectable, arg1: &mut 0x2::tx_context::TxContext) {
        let RareCollectable {
            id          : v0,
            issuer      : _,
            url         : _,
            collectable : _,
            series      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint_DiscountCoupon(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DiscountCoupon{
            id         : 0x2::object::new(arg4),
            issuer     : 0x2::tx_context::sender(arg4),
            discount   : 0x1::ascii::string(arg0),
            expiration : 0x1::ascii::string(arg1),
            url        : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        0x2::transfer::transfer<DiscountCoupon>(v0, arg2);
    }

    public entry fun mint_ExclusiveTicket(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ExclusiveTicket{
            id     : 0x2::object::new(arg4),
            issuer : 0x2::tx_context::sender(arg4),
            url    : 0x2::url::new_unsafe_from_bytes(arg3),
            event  : 0x1::ascii::string(arg0),
            date   : 0x1::ascii::string(arg1),
        };
        0x2::transfer::transfer<ExclusiveTicket>(v0, arg2);
    }

    public entry fun mint_GloriousTrophy(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = GloriousTrophy{
            id     : 0x2::object::new(arg4),
            issuer : 0x2::tx_context::sender(arg4),
            url    : 0x2::url::new_unsafe_from_bytes(arg3),
            rank   : 0x1::ascii::string(arg0),
            event  : 0x1::ascii::string(arg1),
        };
        0x2::transfer::transfer<GloriousTrophy>(v0, arg2);
    }

    public entry fun mint_RareCollectable(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RareCollectable{
            id          : 0x2::object::new(arg4),
            issuer      : 0x2::tx_context::sender(arg4),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
            collectable : 0x1::ascii::string(arg0),
            series      : 0x1::ascii::string(arg1),
        };
        0x2::transfer::transfer<RareCollectable>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

