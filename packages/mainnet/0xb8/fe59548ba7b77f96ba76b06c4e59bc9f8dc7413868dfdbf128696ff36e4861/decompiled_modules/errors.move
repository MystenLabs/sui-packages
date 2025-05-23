module 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::errors {
    struct Errors has drop {
        dummy_field: bool,
    }

    public fun EEmptyPost() : u64 {
        5
    }

    public fun EFeedAlreadyExists() : u64 {
        9
    }

    public fun EFeedNotFound() : u64 {
        8
    }

    public fun ENotAdmin() : u64 {
        1
    }

    public fun EPostTooLong() : u64 {
        6
    }

    public fun EPostTooShort() : u64 {
        7
    }

    public fun EProfileNotExists() : u64 {
        4
    }

    public fun EUnauthorized() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

