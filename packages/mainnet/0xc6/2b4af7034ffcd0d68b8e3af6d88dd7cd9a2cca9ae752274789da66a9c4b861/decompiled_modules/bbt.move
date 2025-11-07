module 0xc62b4af7034ffcd0d68b8e3af6d88dd7cd9a2cca9ae752274789da66a9c4b861::bbt {
    struct BBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBT>(arg0, 9, b"BBT", b"bigbangtoken", b"UTILITY TOKEN SMART SOLUTION FOR EVOLVING PROBLEMS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/imgres?q=bigbang%20THEORY&imgurl=https%3A%2F%2Fscx1.b-cdn.net%2Fcsz%2Fnews%2F800a%2F2015%2F7-whatisthebig.jpg&imgrefurl=https%3A%2F%2Fphys.org%2Fnews%2F2015-12-big-theory.html&docid=lRJd2Cx5qhlPqM&tbnid=Tn-73_nVFCQZUM&vet=12ahUKEwjny9eM2d-QAxXSzjgGHWuaFjcQM3oECBsQAA..i&w=700&h=432&hcb=2&ved=2ahUKEwjny9eM2d-QAxXSzjgGHWuaFjcQM3oECBsQAA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

