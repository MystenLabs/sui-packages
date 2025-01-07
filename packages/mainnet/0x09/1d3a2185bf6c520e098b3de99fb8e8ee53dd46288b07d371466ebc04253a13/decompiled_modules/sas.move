module 0x91d3a2185bf6c520e098b3de99fb8e8ee53dd46288b07d371466ebc04253a13::sas {
    struct SAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAS>(arg0, 9, b"SaS", b"SaSui", b"Keeping it real.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-6wtLCuNKqemAYDEz1GSMyA?se=2024-12-16T07%3A29%3A03Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D604800%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3D6f5d6d79-3ebe-4aeb-9090-31a385e443f3.webp&sig=QhNnSqJAMNzw/BrdTUoeik8503zsukylkYw1fPGw%2BMw%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

