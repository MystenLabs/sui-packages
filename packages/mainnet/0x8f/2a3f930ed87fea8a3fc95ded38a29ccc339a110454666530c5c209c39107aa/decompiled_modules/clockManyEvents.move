module 0x8f2a3f930ed87fea8a3fc95ded38a29ccc339a110454666530c5c209c39107aa::clockManyEvents {
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64,
    }

    entry fun access(arg0: &0x2::clock::Clock) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
        let v1 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v1);
        let v2 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v2);
        let v3 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v3);
        let v4 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v4);
        let v5 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v5);
        let v6 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v6);
        let v7 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v7);
        let v8 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v8);
        let v9 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v9);
        let v10 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v10);
        let v11 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v11);
        let v12 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v12);
        let v13 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v13);
        let v14 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v14);
        let v15 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v15);
        let v16 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v16);
        let v17 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v17);
        let v18 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v18);
        let v19 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v19);
        let v20 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v20);
        let v21 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v21);
        let v22 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v22);
        let v23 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v23);
        let v24 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v24);
        let v25 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v25);
        let v26 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v26);
        let v27 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v27);
        let v28 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v28);
        let v29 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v29);
        let v30 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v30);
        let v31 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v31);
        let v32 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v32);
        let v33 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v33);
        let v34 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v34);
        let v35 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v35);
        let v36 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v36);
        let v37 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v37);
        let v38 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v38);
        let v39 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v39);
        let v40 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v40);
        let v41 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v41);
        let v42 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v42);
        let v43 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v43);
        let v44 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v44);
        let v45 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v45);
        let v46 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v46);
        let v47 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v47);
        let v48 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v48);
        let v49 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v49);
        let v50 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v50);
        let v51 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v51);
        let v52 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v52);
        let v53 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v53);
        let v54 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v54);
        let v55 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v55);
        let v56 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v56);
        let v57 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v57);
        let v58 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v58);
        let v59 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v59);
        let v60 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v60);
        let v61 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v61);
        let v62 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v62);
        let v63 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v63);
        let v64 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v64);
        let v65 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v65);
        let v66 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v66);
        let v67 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v67);
        let v68 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v68);
        let v69 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v69);
        let v70 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v70);
        let v71 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v71);
        let v72 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v72);
        let v73 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v73);
        let v74 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v74);
        let v75 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v75);
        let v76 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v76);
        let v77 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v77);
        let v78 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v78);
        let v79 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v79);
        let v80 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v80);
        let v81 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v81);
        let v82 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v82);
        let v83 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v83);
        let v84 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v84);
        let v85 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v85);
        let v86 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v86);
        let v87 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v87);
        let v88 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v88);
        let v89 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v89);
        let v90 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v90);
        let v91 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v91);
        let v92 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v92);
        let v93 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v93);
        let v94 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v94);
        let v95 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v95);
        let v96 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v96);
        let v97 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v97);
        let v98 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v98);
        let v99 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v99);
        let v100 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v100);
    }

    // decompiled from Move bytecode v6
}

