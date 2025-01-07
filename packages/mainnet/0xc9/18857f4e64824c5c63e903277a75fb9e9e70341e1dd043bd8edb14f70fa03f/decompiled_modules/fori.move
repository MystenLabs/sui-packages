module 0xc918857f4e64824c5c63e903277a75fb9e9e70341e1dd043bd8edb14f70fa03f::fori {
    struct FORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORI>(arg0, 9, b"FORI", b"Fori", b"Fori is a dog's name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-m7uXg4QLXQ3EtQkVLZe5G8aE?se=2024-05-09T07%3A41%3A21Z&sp=r&sv=2023-11-03&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3Df682890c-32ed-4115-9398-109994b479e7.webp&sig=fkUm8yrZxWr6kcT/8YybaeL6yCHgq43BHYkGkO1x32I%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FORI>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

