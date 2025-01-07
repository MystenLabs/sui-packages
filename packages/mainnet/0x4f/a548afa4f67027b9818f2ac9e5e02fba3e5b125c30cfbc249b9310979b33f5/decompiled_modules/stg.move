module 0x4fa548afa4f67027b9818f2ac9e5e02fba3e5b125c30cfbc249b9310979b33f5::stg {
    struct STG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG>(arg0, 9, b"STG", b"strong", x"737472656e67746820616e6420726573696c69656e63652120f09f92aa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95c34ff3-7ef7-4097-ab65-f0657e80b075.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG>>(v1);
    }

    // decompiled from Move bytecode v6
}

