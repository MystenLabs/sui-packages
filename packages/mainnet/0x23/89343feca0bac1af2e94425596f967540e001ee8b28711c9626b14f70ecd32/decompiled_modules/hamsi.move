module 0x2389343feca0bac1af2e94425596f967540e001ee8b28711c9626b14f70ecd32::hamsi {
    struct HAMSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSI>(arg0, 6, b"Hamsi", b"Hamsi on Sui", x"537569204e6574776f726b27c3bc6e64656b6920656e2065c49f6c656e63656c69207665206c657a7a65746c692054c3bc726b206d656d6520636f696e6921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiainrga5jmfkgu4ij3hqduvdk2mvio3h3gmjemrugihpsyvuasq6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAMSI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

