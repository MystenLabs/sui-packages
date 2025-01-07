module 0x28e25095c12b13afca99abba16c1afb62ac7f70e244c16bfd116361632ae0206::simba {
    struct SIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBA>(arg0, 6, b"SIMBA", b"SIMBA SUI", x"53696d6261206f6e205355490a436f6d6d756e697479206f776e656420746f6b656e0a0a576562736974653a2068747470733a2f2f73696d62616f6e7375692e7669702f0a0a547769747465723a2068747470733a2f2f782e636f6d2f53696d62614f6e5375693639", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3598_de84049ee9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

