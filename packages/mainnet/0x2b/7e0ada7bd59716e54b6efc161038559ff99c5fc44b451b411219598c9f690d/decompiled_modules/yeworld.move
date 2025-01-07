module 0x2b7e0ada7bd59716e54b6efc161038559ff99c5fc44b451b411219598c9f690d::yeworld {
    struct YEWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEWORLD>(arg0, 6, b"YEworld", b"Lets change the world Kanye", x"466f72206d652c206d6f6e6579206973206e6f74206d7920646566696e6974696f6e206f6620737563636573732e20496e73706972696e672070656f706c65206973206120646566696e6974696f6e206f6620737563636573732e20285945290a0a496d20612063726561746976652067656e6975732c20616e6420746865726573206e6f206f746865722077617920746f20776f72642069742e2028594529", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038892_403eb8d5a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEWORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YEWORLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

