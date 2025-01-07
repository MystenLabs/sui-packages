module 0x24ec9f09e595bfaa30b6791eee266f8871b161698edb38960ba5cbc328d1f95d::mns {
    struct MNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNS>(arg0, 9, b"MNS", b"MOONSUN", b"FOR LOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd200c41-feec-4499-8deb-248a2b1fb10c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

