module 0x9f6f6cdbc520e01dd180158efe7cda0f2bf8126e158aeb04370619926058c1aa::suineggo {
    struct SUINEGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEGGO>(arg0, 6, b"SUIneggo", b"neggo", b"Demonic Nature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_181845_7381c81cee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

