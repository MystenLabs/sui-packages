module 0xaa9542a5acc7f887a513826188dec37db257ec74d981376c317416bc9ba302e2::pyc {
    struct PYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYC>(arg0, 6, b"PYC", b"Pokemon Yacht Club", x"416c6c2074686520506f6bc3a96d6f6e206a7573742070756c6c656420757020746f2074686520596163687420436c7562206c6f6f6b696e672062617365642061732068656c6c2e2050696b61636875732064726970706564206f75742c204d657774776f7320612066756c6c206f6e206879706562656173742c20616e64206576656e204d6167696b6172707320666c697070696e67204e4654732e204f6e205375692c206f6620636f757273652e0a0a436174636820796f757220506f6bc3a96d6f6e206265666f726520746865207961636874207361696c732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiev66xfutwnckill2uijyo77bms5ptwizbu4d6jb2cqvk7ohcgnx4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PYC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

