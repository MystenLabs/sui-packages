module 0x3ed1855a4991d6e48d0a3691fb2c4fa16efcf7603ac2e30b438c3eb4252dffce::usdd {
    struct USDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDD>(arg0, 6, b"USDD", b"Decentralized USD", x"5553444420e58d8fe8aeaee697a8e59ca8e4b8bae58cbae59d97e993bee8a18ce4b89ae68f90e4be9be69c80e7a8b3e5ae9ae38081e58ebbe4b8ade5bf83e58c96e38081e998b2e7afa1e694b9e38081e697a0e586bbe7bb93e79a84e7a8b3e5ae9ae5b881e7b3bbe7bb9fefbc8ce4b880e4b8aae78bace7ab8be4ba8ee4bbbbe4bd95e4b8ade5bf83e58c96e5ae9ee4bd93e79a84e6b0b8e4b985e7b3bbe7bb9fe380825553444420e9809ae8bf87e5a49ae7a78de4b8bbe6b581e695b0e5ad97e8b584e4baa7efbc88e4be8be5a68220545258e3808155534454efbc89e79a84e8b685e9a29de68ab5e68abce69da5e68b85e4bf9de38082e68ab5e68abce8b584e4baa7e79a84e680bbe4bbb7e580bce6988ee698bee9ab98e4ba8ee6b581e9809ae4b8ade79a842055534444efbc8ce68ab5e68abce78e87e8aebee7bdaee4b8ba2031323025e380825553444420e78eb0e59ca8e58fafe4bba5e59ca8e5a49ae4b8aae4b8bbe6b581e7bd91e7bb9ce4b88ae6b581e9809ae38082e794a8e688b7e58fafe4bba5e9809ae8bf87e8b7a8e993bee6a1a5e59ca8e4b88de5908ce7bd91e7bb9ce4b98be997b4e8bdace7a7bb2055534444e38082e4b88e2054524332302d5553445420e7b1bbe4bcbcefbc8c5553444420e9809ae8bf87e59ca82054524f4e20e4b88ae68f90e4be9be5bfabe9809fe4b894e7bb8fe6b58ee5ae9ee683a0e79a84e4bd93e9aa8ce69da5e6bba1e8b6b3e794a8e688b7e79a84e99c80e6b182e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735267279038.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

