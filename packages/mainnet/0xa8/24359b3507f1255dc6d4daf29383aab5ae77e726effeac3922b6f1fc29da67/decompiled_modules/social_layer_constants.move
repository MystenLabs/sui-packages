module 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_constants {
    public fun allowed_social_platforms() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, social_platform_twitter());
        0x1::vector::push_back<0x1::string::String>(&mut v0, social_platform_discord());
        0x1::vector::push_back<0x1::string::String>(&mut v0, social_platform_telegram());
        0x1::vector::push_back<0x1::string::String>(&mut v0, social_platform_google());
        0x1::vector::push_back<0x1::string::String>(&mut v0, social_platform_github());
        0x1::vector::push_back<0x1::string::String>(&mut v0, social_platform_email());
        v0
    }

    public fun allowed_wallet_keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, wallet_key_sui());
        0x1::vector::push_back<0x1::string::String>(&mut v0, wallet_key_sol());
        0x1::vector::push_back<0x1::string::String>(&mut v0, wallet_key_eth());
        0x1::vector::push_back<0x1::string::String>(&mut v0, wallet_key_btc());
        v0
    }

    public fun bio_max_length() : u64 {
        200
    }

    public fun bio_min_length() : u64 {
        0
    }

    public fun display_name_max_length() : u64 {
        63
    }

    public fun display_name_min_length() : u64 {
        3
    }

    public fun social_platform_discord() : 0x1::string::String {
        0x1::string::utf8(b"discord")
    }

    public fun social_platform_email() : 0x1::string::String {
        0x1::string::utf8(b"email")
    }

    public fun social_platform_github() : 0x1::string::String {
        0x1::string::utf8(b"github")
    }

    public fun social_platform_google() : 0x1::string::String {
        0x1::string::utf8(b"google")
    }

    public fun social_platform_telegram() : 0x1::string::String {
        0x1::string::utf8(b"telegram")
    }

    public fun social_platform_twitter() : 0x1::string::String {
        0x1::string::utf8(b"twitter")
    }

    public fun wallet_key_btc() : 0x1::string::String {
        0x1::string::utf8(b"BTC")
    }

    public fun wallet_key_eth() : 0x1::string::String {
        0x1::string::utf8(b"ETH")
    }

    public fun wallet_key_sol() : 0x1::string::String {
        0x1::string::utf8(b"SOL")
    }

    public fun wallet_key_sui() : 0x1::string::String {
        0x1::string::utf8(b"SUI")
    }

    // decompiled from Move bytecode v6
}

