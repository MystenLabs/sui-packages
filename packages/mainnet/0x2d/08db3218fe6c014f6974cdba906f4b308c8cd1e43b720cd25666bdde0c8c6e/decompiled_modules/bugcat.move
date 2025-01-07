module 0x2d08db3218fe6c014f6974cdba906f4b308c8cd1e43b720cd25666bdde0c8c6e::bugcat {
    struct BUGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGCAT>(arg0, 6, b"BUGCAT", b"Bugcat the sui cat", x"4275676361742c20746865206c6f7661626c792070756467792c207369782d6c656767656420626c75652066656c696e652c206973207468652073746172206f66206f757220636f6d6d756e6974792074616b656f7665722070726f6a656374210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049912_348d09c390.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

