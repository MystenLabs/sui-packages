module 0xd53e5f21f75a58143214942dae9a0489faf753706ab6c83c8249dd640f9dc157::wmdg {
    struct WMDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMDG>(arg0, 6, b"WMDG", b"Worm Dog", b"Chillin' like a cozy little worm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/222_41ea5ca386.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

