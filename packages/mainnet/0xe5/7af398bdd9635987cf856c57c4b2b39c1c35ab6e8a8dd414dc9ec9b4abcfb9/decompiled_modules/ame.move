module 0xe57af398bdd9635987cf856c57c4b2b39c1c35ab6e8a8dd414dc9ec9b4abcfb9::ame {
    struct AME has drop {
        dummy_field: bool,
    }

    fun init(arg0: AME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AME>(arg0, 9, b"AME", b"AME INU", b"AME HAS COME TO MAKE THE LAND GREEN AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bing.com/th?id=OIG1.q35kOza4h77e6eD5wYnk&w=236&c=11&rs=1&qlt=90&bgcl=ececec&o=6&pid=PersonalBing&p=0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AME>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AME>>(v1);
    }

    // decompiled from Move bytecode v6
}

