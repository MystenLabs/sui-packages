module 0x387673dae45cf4d4d7c9e65dae0f5825219e61a06e9d3044a259b090b481d940::thatherus {
    struct THATHERUS has drop {
        dummy_field: bool,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        remaining: u64,
    }

    public fun get_actual_supply() : u64 {
        100000011000000000 - 100000011000000000 * 20 / 100
    }

    public fun get_burn_percentage() : u64 {
        20
    }

    public fun get_initial_supply() : u64 {
        100000011000000000
    }

    fun init(arg0: THATHERUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THATHERUS>(arg0, 9, b"Thather.US", b"USDT", x"55534454e4bba3e5b881202d20546861746865722e5553202d20e983a8e7bdb2e697b6e99480e6af81323025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/usdt.png")), arg1);
        let v2 = v0;
        let v3 = 100000011000000000 * 20 / 100;
        let v4 = 100000011000000000 - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<THATHERUS>>(0x2::coin::mint<THATHERUS>(&mut v2, v4, arg1), 0x2::tx_context::sender(arg1));
        let v5 = BurnEvent{
            amount    : v3,
            remaining : v4,
        };
        0x2::event::emit<BurnEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THATHERUS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THATHERUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

