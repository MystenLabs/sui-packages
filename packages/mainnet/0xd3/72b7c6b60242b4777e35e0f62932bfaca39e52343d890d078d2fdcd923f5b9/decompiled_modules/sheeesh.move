module 0xd372b7c6b60242b4777e35e0f62932bfaca39e52343d890d078d2fdcd923f5b9::sheeesh {
    struct SHEEESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEESH>(arg0, 6, b"SHEEESH", b"SHEESH", x"53686565736821204368696c6c206f75742062726f2e205965612c20796f7527766520666f756e6420612067656d2e205965612c20796f75276c6c206861766520656e6f756768206d6f6e657920666f722074686174206c616d626f20796f7520616c7761797320647265616d74206f662e205965732c207965732c20796f752063616e206665656420796f75722076696c6c6167652e205368656573682e204a757374206a6f696e20757320616c72656164792e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_14_18_56_44_0dae24e504.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEEESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

