module 0xe3c2e016093996b72b78f228d2df50a5c9a94b2b97d95e1d7222172df53aa029::salad {
    struct SALAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALAD>(arg0, 6, b"Salad", b"Adeniyi Salad Bar", b"well, despite adeniyi treating salads like they're the broccoli of his culinary nightmares, we've embarked on a mission to transform him into the king of leafy greens. it's like trying to teach a cat to bark, but hey, stranger things have happened in the kitchen! let the salad adventures begin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmUuNBXtZdMygaNYpP96JiF6qatZev7AB8vfYY2KYcKTDD?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SALAD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALAD>>(v2, @0x2d46457047c785f15763402c663badcf60afc840c5afd132f9745580a7f9dee9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

