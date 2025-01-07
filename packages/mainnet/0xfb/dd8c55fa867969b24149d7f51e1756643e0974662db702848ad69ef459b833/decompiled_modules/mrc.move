module 0xfbdd8c55fa867969b24149d7f51e1756643e0974662db702848ad69ef459b833::mrc {
    struct MRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRC>(arg0, 8, b"MRC", b"MarisqueCoin", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRO9QdrNd3wz6SJaMnRk0MvIpomcnAfgfWIjsI3a2h8QpT5R8UPsqyJI-Wr3S7QtfOXv8M&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MRC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

