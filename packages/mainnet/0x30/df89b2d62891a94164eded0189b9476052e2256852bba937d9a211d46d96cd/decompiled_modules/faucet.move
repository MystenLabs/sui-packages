module 0x30df89b2d62891a94164eded0189b9476052e2256852bba937d9a211d46d96cd::faucet {
    struct Pool has store, key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<0x58c7d502972b4222baf66349d046f40fbad3db01df54c8026071ac7240ac6406::usda::USDA>,
    }

    public entry fun add_usdc(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x58c7d502972b4222baf66349d046f40fbad3db01df54c8026071ac7240ac6406::usda::USDA>) {
        0x2::balance::join<0x58c7d502972b4222baf66349d046f40fbad3db01df54c8026071ac7240ac6406::usda::USDA>(&mut arg0.vault, 0x2::coin::into_balance<0x58c7d502972b4222baf66349d046f40fbad3db01df54c8026071ac7240ac6406::usda::USDA>(arg1));
    }

    public entry fun faucet_usdc(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x58c7d502972b4222baf66349d046f40fbad3db01df54c8026071ac7240ac6406::usda::USDA>>(0x2::coin::take<0x58c7d502972b4222baf66349d046f40fbad3db01df54c8026071ac7240ac6406::usda::USDA>(&mut arg0.vault, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id    : 0x2::object::new(arg0),
            vault : 0x2::balance::zero<0x58c7d502972b4222baf66349d046f40fbad3db01df54c8026071ac7240ac6406::usda::USDA>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    // decompiled from Move bytecode v6
}

