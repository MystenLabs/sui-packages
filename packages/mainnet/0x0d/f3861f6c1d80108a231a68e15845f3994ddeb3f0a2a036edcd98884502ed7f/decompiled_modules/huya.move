module 0xdf3861f6c1d80108a231a68e15845f3994ddeb3f0a2a036edcd98884502ed7f::huya {
    struct HUYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUYA>(arg0, 9, b"HUYA", b"Huyamba", x"506f776572656420627920746865206c6567656e646172792068616c662d756e69636f726e2c2068616c662d6d6f6e6b65792063726561747572652c20485559414d4241206973206865726520746f20737072696e6b6c65206d6167696320616e642062616e616e617320696e746f207468652063727970746f20776f726c642e204a6f696e20746865206a756e676c65206f6620647265616d657273e2809462656361757365207768656e206c69666520676574732077656972642c20485559414d42412067657473207765697264657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3217e368-750b-49e7-a24f-11e6933492d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

