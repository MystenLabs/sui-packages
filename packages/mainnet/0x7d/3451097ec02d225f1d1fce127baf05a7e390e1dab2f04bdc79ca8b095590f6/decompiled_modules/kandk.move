module 0x7d3451097ec02d225f1d1fce127baf05a7e390e1dab2f04bdc79ca8b095590f6::kandk {
    struct KANDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KANDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANDK>(arg0, 9, b"KANDK", b"K&K", b"K&K Group", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22ea9686-ffc8-4f6c-a57d-a0d432814940-17CCCD40-1ACB-45E2-B870-B235D1598EB7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KANDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KANDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

