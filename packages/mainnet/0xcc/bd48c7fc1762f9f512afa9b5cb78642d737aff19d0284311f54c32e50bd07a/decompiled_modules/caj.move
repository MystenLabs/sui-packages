module 0xccbd48c7fc1762f9f512afa9b5cb78642d737aff19d0284311f54c32e50bd07a::caj {
    struct CAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAJ>(arg0, 8, b"CAJ", b"Confidence, assurance and joy", b"No FUD allowed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-xdMdDsBVkmAvrRaZHOjTwlaz?se=2023-12-15T10%3A23%3A57Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D2e383d00-82fd-4df5-88d5-084a432c7f90.webp&sig=uugPDIlhIdiF03NGdolxuuTQsCcUYMoJ52aSY6MEp3k%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAJ>(&mut v2, 10000000100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAJ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

