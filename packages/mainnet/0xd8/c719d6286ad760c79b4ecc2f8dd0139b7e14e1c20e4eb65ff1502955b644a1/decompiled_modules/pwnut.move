module 0xd8c719d6286ad760c79b4ecc2f8dd0139b7e14e1c20e4eb65ff1502955b644a1::pwnut {
    struct PWNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWNUT>(arg0, 6, b"PWNUT", b"Pwnut", x"537175697272656c2c204e75742c20616e642046726f672020627574206974206c6f6f6b73206c696b6520746865207265616c2046776f673f2120200a0a46776f673f204e61682c20697473206c6f6f6b696e206d6f7265206c696b652061204e757421200a0a477565737320697473206665656c696e27206c696b652061202450574e55542120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241201_195541_030_59320ec940.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

