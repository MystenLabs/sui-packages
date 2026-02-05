module 0xb52b19fa40bca8a86f5802e2dae73ee388477b3c181ccd16df4374d28b859258::imblank {
    struct IMBLANK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<IMBLANK>, arg1: 0x2::coin::Coin<IMBLANK>) {
        0x2::coin::burn<IMBLANK>(arg0, arg1);
    }

    fun init(arg0: IMBLANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMBLANK>(arg0, 6, b"IMBLANK", b"ImBlank", b"Im Blank! What should i do here?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1944598631010668544/laJp_QXG_400x400.jpg#1770274688344859000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMBLANK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMBLANK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<IMBLANK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IMBLANK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

