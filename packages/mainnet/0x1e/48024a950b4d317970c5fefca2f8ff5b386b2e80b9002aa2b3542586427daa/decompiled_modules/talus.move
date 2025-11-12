module 0x1e48024a950b4d317970c5fefca2f8ff5b386b2e80b9002aa2b3542586427daa::talus {
    struct TALUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TALUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TALUS>(arg0, 9, b"TALUS", b"Talus Network", b"Cutting-edge blockchain Talus Network aims to create a more equitable and accessible technological future. In Talus Network, a harmoniously designed ecosystem coupled with the right developer tools enables smart agents to collaborate, innovate, and support decentralized applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.images.dropstab.com/images/talus-network.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TALUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TALUS>>(0x2::coin::mint<TALUS>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TALUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

