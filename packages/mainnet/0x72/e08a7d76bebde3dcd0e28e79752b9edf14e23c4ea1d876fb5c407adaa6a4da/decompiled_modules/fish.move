module 0x72e08a7d76bebde3dcd0e28e79752b9edf14e23c4ea1d876fb5c407adaa6a4da::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"Bubblefish", x"427562626c6566697368206279204d6174742046757269652e200a0a4120646567656e657261746520427562626c656669736820726561647920746f206d616b65207761766573206f6e20537569210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bubblefish_profilbilde_427d20d220.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

