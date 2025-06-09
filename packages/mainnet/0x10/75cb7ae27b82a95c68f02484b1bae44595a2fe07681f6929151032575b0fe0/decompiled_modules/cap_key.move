module 0x1075cb7ae27b82a95c68f02484b1bae44595a2fe07681f6929151032575b0fe0::cap_key {
    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun cap_key() : CapKey {
        CapKey{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

