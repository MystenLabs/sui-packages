module 0x9d7e314ad0382edba9867e9c0bada5298c0b6b884ca1dfd609341344a9976ae9::dxb {
    struct DXB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXB>(arg0, 9, b"DXB", b"dubai", b"Luxurious and captivating, inspired by the luxury and grandeur of Dubai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/216031ad-67f2-4744-bd4d-7099f27c1492.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXB>>(v1);
    }

    // decompiled from Move bytecode v6
}

