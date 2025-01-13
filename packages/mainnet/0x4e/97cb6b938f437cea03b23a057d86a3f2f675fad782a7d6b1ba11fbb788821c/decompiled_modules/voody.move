module 0x4e97cb6b938f437cea03b23a057d86a3f2f675fad782a7d6b1ba11fbb788821c::voody {
    struct VOODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOODY>(arg0, 6, b"Voody", b"Voody Sui", b"In the world of magic, Voody reigns supreme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pfp_launch_ae7418ee7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOODY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOODY>>(v1);
    }

    // decompiled from Move bytecode v6
}

