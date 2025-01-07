module 0x5b0c49f657b14688b04035ad5f34a294222d8fe31ddc00afd8d26b121a6458::ssq {
    struct SSQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSQ>(arg0, 9, b"SSQ", b"SUIcide Sq", b"Joker and Harley Quinn are merged into one to bring even more violence with their water guns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b0e07c4-3d79-4a45-86a5-9b0b89ad479d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

