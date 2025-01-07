module 0xd75aa7419f5f68a3fa0b04adb64caa2678969709c978573bea1919953b6f2817::Token {
    struct Token has copy, drop, store {
        owner: address,
        total_supply: u64,
    }

    public fun mint(arg0: address, arg1: u64) : Token {
        Token{
            owner        : arg0,
            total_supply : arg1,
        }
    }

    public fun transfer(arg0: address, arg1: address) {
    }

    // decompiled from Move bytecode v6
}

