module 0x8314b20b9b431bde5578543aedda7ccc877e5088aeee7feba3dbbdee4df02fc::dng {
    struct DNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNG>(arg0, 9, b"DNG", b"GiangDN", b"Goooooood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/511542ea-76d8-4701-99ff-765e1bfd02d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

