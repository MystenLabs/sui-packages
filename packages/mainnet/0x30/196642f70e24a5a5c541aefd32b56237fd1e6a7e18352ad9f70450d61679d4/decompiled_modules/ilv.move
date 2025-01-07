module 0x30196642f70e24a5a5c541aefd32b56237fd1e6a7e18352ad9f70450d61679d4::ilv {
    struct ILV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILV>(arg0, 9, b"ILV", b"Ilovesui", b"I love sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ILV>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILV>>(v1);
    }

    // decompiled from Move bytecode v6
}

