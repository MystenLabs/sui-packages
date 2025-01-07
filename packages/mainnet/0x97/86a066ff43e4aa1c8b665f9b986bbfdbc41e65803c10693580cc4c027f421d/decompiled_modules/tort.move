module 0x9786a066ff43e4aa1c8b665f9b986bbfdbc41e65803c10693580cc4c027f421d::tort {
    struct TORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORT>(arg0, 9, b"TORT", b"TORT", b"Babushin' Tort", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwDrIG-lwb9G3BCnZwxoU2Ll7Xjr12akbELA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TORT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORT>>(v1);
    }

    // decompiled from Move bytecode v6
}

