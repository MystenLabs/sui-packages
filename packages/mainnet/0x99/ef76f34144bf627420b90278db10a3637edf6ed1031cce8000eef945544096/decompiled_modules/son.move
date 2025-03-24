module 0x99ef76f34144bf627420b90278db10a3637edf6ed1031cce8000eef945544096::son {
    struct SON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SON>(arg0, 6, b"SoN", b"Soap On Sui", x"48657920696e766573746f72732120200a5965732c20796f75206865617264206974207269676874200a776527726520736f6172696e67206f6e20736f617020627562626c65730a416e6420677565737320776861743f2057657265207468652070696f6e65657273206f66207468697320756e6971756520746f6b656e2120200a0a546869732069736e74206a757374206120717569636b20666c697021200a7765726520696e20697420666f7220746865206c6f6e672072756e2e200a0a4c65747320676f20666f7220736f617020627562626c6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soap_218b133d8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SON>>(v1);
    }

    // decompiled from Move bytecode v6
}

