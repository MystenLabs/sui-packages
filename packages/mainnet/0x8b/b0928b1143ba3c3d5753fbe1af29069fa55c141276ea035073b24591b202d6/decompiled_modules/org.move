module 0x8bb0928b1143ba3c3d5753fbe1af29069fa55c141276ea035073b24591b202d6::org {
    struct ORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORG>(arg0, 9, b"ORG", b"Origami", b"let's fold papers toghether and make origami for eachother", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea91dc41-7544-49d0-81a6-ad7afdca1293.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

