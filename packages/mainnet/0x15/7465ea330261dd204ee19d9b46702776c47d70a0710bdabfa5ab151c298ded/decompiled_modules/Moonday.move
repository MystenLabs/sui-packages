module 0x157465ea330261dd204ee19d9b46702776c47d70a0710bdabfa5ab151c298ded::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/452909ff-c127-4e36-9b98-494b25b2b52a/mr_orangex_a_rick_and_morty_style_character_posing_for_the_caem_1c341170-7843-45ba-a9cb-be4763771d65.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/452909ff-c127-4e36-9b98-494b25b2b52a/mr_orangex_a_rick_and_morty_style_character_posing_for_the_caem_1c341170-7843-45ba-a9cb-be4763771d65.png"))
        };
        let v1 = b"aZOMBIE";
        let v2 = b"bZombie Rick";
        let v3 = x"63506f776572656420627920746865206d756c746976657273652773206269676765737420626f6f7a652d6c6f76696e672c206265742d706c6163696e67206d616420736369656e7469737421205269636b1973206865726520746f207761727020796f75722062616773207769746820696e74657264696d656e73696f6e616c206761696e73146f7220746f74616c206368616f732e2057616e6e6120726f6c6c207468652064696365207769746820746865206472756e6b6573742067656e6975732061726f756e643f205775626261204c75626261204475622d446567656e";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

