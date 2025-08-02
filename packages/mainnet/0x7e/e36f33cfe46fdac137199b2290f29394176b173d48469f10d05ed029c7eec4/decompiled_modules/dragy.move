module 0x7ee36f33cfe46fdac137199b2290f29394176b173d48469f10d05ed029c7eec4::dragy {
    struct DRAGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGY>(arg0, 6, b"DRAGY", b"Dragy On Sui", b"Dragy is a community-based memecoin that combines the symbolic power of dragons with the simplicity of modern meme economics. Built on the Sui blockchain, Dragy arrives with no false promises only community, transparency, and viral potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic4kh3desskh2qthaukdjcajpvulphinuotl7se5amdwudo5wgs54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

