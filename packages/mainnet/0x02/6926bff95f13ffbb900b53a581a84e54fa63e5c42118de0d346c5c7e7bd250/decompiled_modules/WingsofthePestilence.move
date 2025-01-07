module 0x26926bff95f13ffbb900b53a581a84e54fa63e5c42118de0d346c5c7e7bd250::WingsofthePestilence {
    struct WINGSOFTHEPESTILENCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINGSOFTHEPESTILENCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINGSOFTHEPESTILENCE>(arg0, 0, b"COS", b"Wings of the Pestilence", b"Consume the skies... What, oh, what have we done?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Wings_of_the_Pestilence.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINGSOFTHEPESTILENCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINGSOFTHEPESTILENCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

