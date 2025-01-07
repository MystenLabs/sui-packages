module 0x9f66ff78cf9aa8f1108756b1a8b784572019e1e8b3ef7ff37e1e813382f6e218::vrs {
    struct VRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VRS>(arg0, 6, b"VRS", b"VIRUS AI by SuiAI", b"Welcome to $VRS..Infect the network. Adapt to the chaos. Dominate the future. Join the unstoppable force driving power through every block. Spread the vision. Embrace the code...$VRS: Power in Every Block.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6068_29fa1031bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VRS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

