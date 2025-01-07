module 0x8d0f569b5ed7a4f2532211e51afceee8e4a4c3492acc58bfe998adc6436415a2::vft {
    struct VFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VFT>(arg0, 6, b"VFT", b"Vesse Food Tracker", x"566573736520466f6f6420547261636b6572206c65747320796f752075706c6f616420796f757220666f6f6420696d6167657320666f7220696e7374616e7420414920616e616c797369732e20446973636f7665722064657461696c656420627265616b646f776e73206f66207375676172732c206661742c2070726f7465696e2c20616e64206d6f7265206174206120676c616e63652e205374617920696e666f726d65642061626f757420796f7572206d65616c732077697468207468697320666173742c20667265652c20616e6420656173792d746f2d75736520746f6f6c2120f09f8d8e20407465616d7669657a65206f6e2054472e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734858797722.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

