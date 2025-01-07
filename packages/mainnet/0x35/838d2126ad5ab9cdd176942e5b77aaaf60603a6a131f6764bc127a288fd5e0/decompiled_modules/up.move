module 0x35838d2126ad5ab9cdd176942e5b77aaaf60603a6a131f6764bc127a288fd5e0::up {
    struct UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP>(arg0, 9, b"UP", b"MoveUp", b"Let's move UP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1744477796301496320/z7AIB7_W.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UP>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UP>>(v1);
    }

    // decompiled from Move bytecode v6
}

