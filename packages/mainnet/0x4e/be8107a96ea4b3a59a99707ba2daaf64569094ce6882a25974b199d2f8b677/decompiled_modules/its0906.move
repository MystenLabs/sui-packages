module 0x4ebe8107a96ea4b3a59a99707ba2daaf64569094ce6882a25974b199d2f8b677::its0906 {
    struct ITS0906 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ITS0906>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ITS0906>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ITS0906, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeiauvxnxnm6jirdnxm62wb37asjwq7icpqzdgtskxctgfyf6uc4ipq";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeiauvxnxnm6jirdnxm62wb37asjwq7icpqzdgtskxctgfyf6uc4ipq"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<ITS0906>(arg0, 9, b"its0906", b"Its0906", b"oK Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<ITS0906>>(0x2::coin::mint<ITS0906>(&mut v5, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITS0906>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ITS0906>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ITS0906>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

