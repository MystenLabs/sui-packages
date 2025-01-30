module 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::events {
    public fun increment_event(arg0: u32) {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_set_record<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::increment_event::IncrementEvent, 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::increment_event::IncrementEvent, 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::increment_event::IncrementEvent>(0x1::ascii::string(b"increment_event"), 0x1::option::none<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::increment_event::IncrementEvent>(), 0x1::option::none<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::increment_event::IncrementEvent>(), 0x1::option::some<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::increment_event::IncrementEvent>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::increment_event::new(arg0)));
    }

    // decompiled from Move bytecode v6
}

