module 0xc5bd4adf25b1d7dd790b751560e2ba444b281504c8003fe854bdb47e40385574::isitcake {
    struct ISITCAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISITCAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISITCAKE>(arg0, 6, b"IsitCake", b"Is it Cake Coin", x"4e6f2066726f7374696e67206f766572207468652064657461696c73e280947765e2809972652066756c6c79207472616e73706172656e742c207275672d667265652c20616e642062616b6564206672657368207769746820616e74692d7363616d20696e6772656469656e74732e205768657468657220796f75277265206865726520666f72206c6175676873206f72206c6179657273206f66206761696e732c202443414b4520697320796f7572207065726665637420736c696365206f66207468652063727970746f207069652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735923836133.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISITCAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISITCAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

