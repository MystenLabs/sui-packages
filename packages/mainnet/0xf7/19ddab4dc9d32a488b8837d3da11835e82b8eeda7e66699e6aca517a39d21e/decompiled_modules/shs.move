module 0xf719ddab4dc9d32a488b8837d3da11835e82b8eeda7e66699e6aca517a39d21e::shs {
    struct SHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHS>(arg0, 9, b"SHS", b"Sui Hacker House Seoul", b"Sui Hacker House Seoul LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-h7N12FkUa1iJjpsRcTtzF1X9?se=2024-04-27T02%3A58%3A48Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D2bdc893c-c72b-4297-90f1-fd085b5a9335.webp&sig=Sf5hKQnAxcWiwWLr5CKPgL3qeIKVZlfsV8fo0QSa8CE%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHS>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

