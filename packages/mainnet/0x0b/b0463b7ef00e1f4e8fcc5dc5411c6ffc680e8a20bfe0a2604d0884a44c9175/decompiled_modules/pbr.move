module 0xbb0463b7ef00e1f4e8fcc5dc5411c6ffc680e8a20bfe0a2604d0884a44c9175::pbr {
    struct PBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBR>(arg0, 9, b"PBR", b"Porelessbr", b"Uniquely created indivisible poreless bress", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d35407c-98eb-43e0-a3ad-7db402ee2b08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

