module 0xc2a718b8fc2393e8a5ce470098b1c6afe74b2fdad075cff948d5ef98c909e9af::suie {
    struct SUIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIE>(arg0, 9, b"SUIE", b"Suiempire", x"53756920456d706972652069736ee2809974206a75737420616e6f74686572206d656d6520746f6b656e3b206974e28099732061206d6f76656d656e742e204275696c7420666f722074686f73652077697468206469616d6f6e642068616e647320616e6420612073656e7365206f662068756d6f722c2053756920456d70697265206973206120746f6b656e20796f75e280996c6c2077616e7420746f20484f444c2061732070617274206f662061206c6567656e6461727920636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/750fb4f7-531c-4e93-adc8-1d4614356bf9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

