module 0xe1d514586853686b92c2de3515337b0f3ddf4ce1b2bceccce4fc98b44adf4edd::more {
    struct MORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORE>(arg0, 8, b"MORE", b"MORE", x"412066756c6c2d737461636b20576562332067616d696e672065636f73797374656d207768657265207175616c697479206d6565747320766973696f6e20e28094206275696c7420666f722067616d6572732c20706f776572656420627920244d4f5245207c20446576656c6f70696e67200a406173747261726b5f776f726c640a20616e642042757368776861636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/8889069b-9416-4274-9ea7-ca78dae5429d.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MORE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

