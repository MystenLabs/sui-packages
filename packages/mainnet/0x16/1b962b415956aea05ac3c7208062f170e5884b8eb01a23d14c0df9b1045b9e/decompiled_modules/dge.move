module 0x161b962b415956aea05ac3c7208062f170e5884b8eb01a23d14c0df9b1045b9e::dge {
    struct DGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGE>(arg0, 9, b"DGE", b"DogElon", b"Elon mosk dogg memem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tse3.mm.bing.net/th?id=OIP.0prEiQTtaqkLy7xXbDjNhwHaFj&pid=Api&P=0&h=180")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DGE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

