module 0xb858151a74039ad7463951b76fa3a4649f594b7f41b2a4a5eb71de133788dc9a::smf {
    struct SMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMF>(arg0, 6, b"SMF", b"Smurf", x"536d75726620737569207375690a4e6f2054617865732c204e6f2042756c6c736869742e2049747320746861742073696d706c650a68747470733a2f2f7475736b6f2e6d792e63616e76612e736974652f7468652d736d75726673", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U_U_U_U_U_U_U_U_U_U_U_U_U_U_5094aa9538.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

