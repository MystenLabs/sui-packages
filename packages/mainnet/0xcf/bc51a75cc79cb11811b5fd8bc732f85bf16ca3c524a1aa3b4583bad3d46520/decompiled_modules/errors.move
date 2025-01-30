module 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::errors {
    public fun invalid_increment_error(arg0: bool) {
        assert!(arg0, 9223372096984317953);
    }

    // decompiled from Move bytecode v6
}

