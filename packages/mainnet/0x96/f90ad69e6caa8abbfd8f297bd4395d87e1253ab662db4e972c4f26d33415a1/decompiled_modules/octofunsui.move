module 0x96f90ad69e6caa8abbfd8f297bd4395d87e1253ab662db4e972c4f26d33415a1::octofunsui {
    struct OCTOFUNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOFUNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOFUNSUI>(arg0, 9, b"OctofunSui", b"OctofunSui", b"Octopass is coming to Sui market - A meme token acting like a meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/t5MOGGB.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCTOFUNSUI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOFUNSUI>>(v2, @0x328a29036a1b374bfff1e377f1ccaf380d599d424e64ba180aa400340447c785);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOFUNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

