module 0x85b39b3526ec2495a103ea00f654c5fd195444f2b78f98b3d3325b5fca240169::suiperman {
    struct SUIPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERMAN>(arg0, 6, b"SUIPERMAN", b"Suiperman", b"SUIPERMAN is the superhero version of the Sui blockchain, portrayed as a hero who tackles the common issues of traditional blockchains: slowness, high fees, and limited scalability. Like a \"Superman\" for crypto, Suieprman promises fast transactions, low costs, and a powerful, scalable network, making the blockchain experience accessible and efficient for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056574_bcb0a591af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

