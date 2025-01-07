module 0x9dd36f799ba641c91760ebdc4d87502d0acadcce77ed033c0056439b03b37d0b::vampire {
    struct VAMPIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAMPIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAMPIRE>(arg0, 9, b"vampire", b"Vampire", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/426/534/large/rui-guo-nv-nv-1111122.jpg?1727542350")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VAMPIRE>(&mut v2, 300000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAMPIRE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAMPIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

